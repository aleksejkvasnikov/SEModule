#ifndef QMLTRANSLATOR_H
#define QMLTRANSLATOR_H

#include <QObject>
#include <QTranslator>

class QmlTranslator : public QObject
{
 Q_OBJECT
 Q_PROPERTY(QString emptyString READ getEmptyString NOTIFY languageChanged)
 Q_PROPERTY(double fontVal READ fontVal WRITE setfontVal)
 Q_PROPERTY(QString locale READ locale WRITE setlocale NOTIFY localeChanged)
 public:
  QmlTranslator() {
   translator1 = new QTranslator(this);
  }
  void setfontVal(const double &a) { if (a != m_fontVal) { m_fontVal = a;} }
  double fontVal() const { return m_fontVal; }
  void setlocale(const QString &locale) { if (locale != m_locale) { m_locale = locale;} }
  QString locale() const { return m_locale; }

  QString getEmptyString() {
   return "";
  }

 Q_INVOKABLE void selectLanguage(QString language);
 Q_INVOKABLE void selectLocale(QString locale);
 signals:
  void languageChanged();
  void localeChanged();
 private:
  QTranslator *translator1;
  double m_fontVal = 0;
  QString m_locale = "ru_RU";
};

#endif // QMLTRANSLATOR_H
