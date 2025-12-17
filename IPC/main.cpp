// ============================================
// IPC APPLICATION WITH COVERAGE TESTING
// ============================================
// Simple Qt application with buttons to test
// Bullseye coverage instrumentation
// ============================================

#include <QApplication>
#include <QMainWindow>
#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>
#include <QTime>
#include <QDebug>

// Increment this to force recompilation when needed
#define BUILD_VERSION 2

class MainWindow : public QMainWindow {
    Q_OBJECT  // Qt Meta-Object System (requires moc)
    
public:
    MainWindow(QWidget *parent = nullptr) : QMainWindow(parent) {
        // Set window title with build version
        setWindowTitle(QString("IPC Coverage Test - Build %1").arg(BUILD_VERSION));
        
        // Create central widget and layout
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *layout = new QVBoxLayout(centralWidget);
        
        // Application title label
        QLabel *titleLabel = new QLabel("IPC Application - Coverage Test", centralWidget);
        titleLabel->setAlignment(Qt::AlignCenter);
        QFont titleFont = titleLabel->font();
        titleFont.setPointSize(14);
        titleFont.setBold(true);
        titleLabel->setFont(titleFont);
        layout->addWidget(titleLabel);
        
        // Status label
        QLabel *statusLabel = new QLabel("Ready for coverage testing...", centralWidget);
        statusLabel->setAlignment(Qt::AlignCenter);
        layout->addWidget(statusLabel);
        
        // Test buttons (these will be covered by Bullseye)
        QPushButton *testBtn1 = new QPushButton("Execute Function A", centralWidget);
        QPushButton *testBtn2 = new QPushButton("Execute Function B", centralWidget);
        QPushButton *exitBtn = new QPushButton("Exit Application", centralWidget);
        
        layout->addWidget(testBtn1);
        layout->addWidget(testBtn2);
        layout->addWidget(exitBtn);
        
        // ============================================
        // FUNCTIONS FOR COVERAGE TESTING
        // ============================================
        
        // Function A - Simple text update
        connect(testBtn1, &QPushButton::clicked, [statusLabel]() {
            statusLabel->setText("Function A executed at: " + QTime::currentTime().toString());
            qDebug() << "[Coverage] Function A executed";
        });
        
        // Function B - Different text update
        connect(testBtn2, &QPushButton::clicked, [statusLabel]() {
            statusLabel->setText("Function B executed at: " + QTime::currentTime().toString());
            qDebug() << "[Coverage] Function B executed";
        });
        
        // Exit function
        connect(exitBtn, &QPushButton::clicked, qApp, &QApplication::quit);
        
        // Set window size
        resize(500, 350);
    }
};

// ============================================
// MAIN FUNCTION
// ============================================
int main(int argc, char *argv[]) {
    // Initialize Qt application
    QApplication app(argc, argv);
    
    // Create and show main window
    MainWindow window;
    window.show();
    
    // Start event loop
    return app.exec();
}

// Include meta-object compilation output
#include "main.moc"