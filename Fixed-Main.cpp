
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#include <QDebug>
#include <QDBusInterface>
#include <QDBusConnection>

class RealTelemetry : public QObject {
    Q_OBJECT
    Q_PROPERTY(int cpuTemp READ cpuTemp NOTIFY updated)
    Q_PROPERTY(int gpuTemp READ gpuTemp NOTIFY updated)
    Q_PROPERTY(int liquidTemp READ liquidTemp NOTIFY updated)
public:
    explicit RealTelemetry(QObject* parent=nullptr) : QObject(parent) {}
    int cpuTemp() const { return m_cpu; }
    int gpuTemp() const { return m_gpu; }
    int liquidTemp() const { return m_liquid; }
    Q_INVOKABLE void refresh() {
        // Пример чтения из uccd, раскомментируй когда uccd запущен
        // QDBusInterface iface("org.ucc.daemon","/org/ucc/daemon","org.ucc.daemon", QDBusConnection::systemBus());
        // if(iface.isValid()) {
        //   auto r = iface.call("GetCpuTemp");
        //   if(!r.arguments().isEmpty()) m_cpu = r.arguments().first().toInt();
        // }
        // пока моки чтобы собралось
        m_cpu = 67 + (rand()%5);
        m_gpu = 53 + (rand()%4);
        m_liquid = 38 + (rand()%2);
        Q_EMIT updated();
    }
signals:
    void updated();
private:
    int m_cpu=67,m_gpu=53,m_liquid=38;
};

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    app.setApplicationName("ucc-ucu-ui");
    RealTelemetry telemetry;
    telemetry.refresh();
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Telemetry", &telemetry);
    QTimer timer;
    QObject::connect(&timer,&QTimer::timeout,[&](){ telemetry.refresh(); });
    timer.start(2000);
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/UCC/UCU/qml/Main.qml")));
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load Main.qml, trying fallback";
        engine.load(QUrl(QStringLiteral("qrc:/UCC/UCU/qml/pages/Dashboard.qml")));
    }
    if (engine.rootObjects().isEmpty()) return -1;
    return app.exec();
}
#include "main.moc"
