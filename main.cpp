#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtDataVisualization>
#include <QQmlContext>
#include <QTranslator>
#include <surfacemodel.h>
#include <surfacemodellist.h>
#include <Qt3DQuickExtras/qt3dquickwindow.h>
#include <QGuiApplication>
#include "qmltranslator.h"
#include "hzformatter.h"
#include "customplotitem.h"
//#include "opti_fileobject.h"
Q_DECLARE_METATYPE(HZformatter *)

using namespace QtDataVisualization;
int main(int argc, char *argv[])
{

    QLibrary lib( "Comctl32.dll" );
    lib.setLoadHints( QLibrary::ResolveAllSymbolsHint );
    lib.load();
   // QLocale::setDefault(QLocale::Russian);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    // Создаём объект для работы с переводами ...
    QmlTranslator qmlTranslator;

    #ifdef _WIN32
        MEMORYSTATUSEX memory_status;
        ZeroMemory(&memory_status, sizeof(MEMORYSTATUSEX));
        memory_status.dwLength = sizeof(MEMORYSTATUSEX);
        if (GlobalMemoryStatusEx(&memory_status)) {
          qDebug() << QString("RAM: %1 MB").arg(memory_status.ullTotalPhys / (1024 * 1024));
        } else {
          qDebug() << "Unknown RAM" ;
        }
    #endif
    QApplication app(argc, argv);
    qmlRegisterType<HZformatter>("HZformatter", 1, 0, "HZformatter");
    qmlRegisterType<CustomPlotItem>("CustomPlot", 1, 0, "CustomPlotItem");
    qRegisterMetaType<QVector<surfaceModelItem>>("QVector<surfaceModelItem>");
    qmlRegisterType<SurfaceModel>("SfModel", 1, 0, "SurfaceModel");
    qmlRegisterUncreatableType<surfaceModelList>("SfModel", 1, 0, "surfaceModelList",
        QStringLiteral("Coudlnt be created"));
    surfaceModelList sfmList;
   // CustomPlotItem plot;
    //sfmList.plot2D = &plot;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty(QStringLiteral("modList"), &sfmList);
    engine.rootContext()->setContextProperty("rootItem", &qmlTranslator);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
