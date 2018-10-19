#include "qmltranslator.h"
#include "QDebug"
#include <QApplication>

void QmlTranslator::selectLanguage(QString language) {
  if(language == QString("en_US")) {
   translator1->load("QtLanguage_en", ".");
   qApp->installTranslator(translator1);
  }

  if(language == QString("ru_RU")) {
   qApp->removeTranslator(translator1);
  }

  if (language == QString("fr_FR"))
  {
      translator1->load("QtLanguage_fr", ".");
      qApp->installTranslator(translator1);
  }

  emit languageChanged();
 }

void QmlTranslator::updateStrings() {
  emit languageChanged();
 }

void QmlTranslator::selectLocale(QString locale) {
  m_locale = locale;
  emit localeChanged();
 }
