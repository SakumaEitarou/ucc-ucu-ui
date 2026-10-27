
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "dbus_client.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    app.setApplicationName("ucc-ucu-ui");
    app.setOrganizationName("nanomatters");

    UccDbus backend;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("UccBackend", &backend);
    engine.load(QUrl(QStringLiteral("qrc:/UCC/UCU/qml/Main.qml")));
    if (engine.rootObjects().isEmpty()) return -1;
    return app.exec();
}
