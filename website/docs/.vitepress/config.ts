import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Talker',
  description: 'Advanced error handler and logger for Dart and Flutter apps',

  head: [
    ['link', { rel: 'icon', href: '/logo.png' }],
  ],

  locales: {
    root: {
      label: 'English',
      lang: 'en',
      themeConfig: {
        nav: [
          { text: 'Guide', link: '/getting-started/installation' },
          { text: 'Packages', link: '/packages/talker' },
          { text: 'Integrations', link: '/integrations/dio' },
          {
            text: 'Links',
            items: [
              { text: 'pub.dev', link: 'https://pub.dev/packages/talker' },
              { text: 'GitHub', link: 'https://github.com/Frezyx/talker' },
              { text: 'Web Demo', link: 'https://frezyx.github.io/talker' },
            ],
          },
        ],
        sidebar: {
          '/': [
            {
              text: 'Getting Started',
              collapsed: false,
              items: [
                { text: 'Installation', link: '/getting-started/installation' },
                { text: 'Quick Start', link: '/getting-started/quick-start' },
                { text: 'Why Talker?', link: '/getting-started/why-talker' },
              ],
            },
            {
              text: 'Core Packages',
              collapsed: false,
              items: [
                { text: 'talker', link: '/packages/talker' },
                { text: 'talker_logger', link: '/packages/talker-logger' },
                { text: 'talker_flutter', link: '/packages/talker-flutter' },
              ],
            },
            {
              text: 'Integrations',
              collapsed: false,
              items: [
                { text: 'Dio Logger', link: '/integrations/dio' },
                { text: 'HTTP Logger', link: '/integrations/http' },
                { text: 'BLoC Logger', link: '/integrations/bloc' },
                { text: 'Riverpod Logger', link: '/integrations/riverpod' },
                { text: 'Chopper Logger', link: '/integrations/chopper' },
                { text: 'gRPC Logger', link: '/integrations/grpc' },
              ],
            },
            {
              text: 'Guides',
              collapsed: false,
              items: [
                { text: 'Custom Log Types', link: '/guides/custom-logs' },
                { text: 'Crashlytics Integration', link: '/guides/crashlytics' },
                { text: 'Route Logging', link: '/guides/routing' },
                { text: 'Custom Error Messages', link: '/guides/custom-error-messages' },
              ],
            },
            {
              text: 'Examples',
              link: '/examples',
            },
          ],
        },
      },
    },
    ru: {
      label: 'Русский',
      lang: 'ru',
      link: '/ru/',
      themeConfig: {
        nav: [
          { text: 'Руководство', link: '/ru/getting-started/installation' },
          { text: 'Пакеты', link: '/ru/packages/talker' },
          { text: 'Интеграции', link: '/ru/integrations/dio' },
          {
            text: 'Ссылки',
            items: [
              { text: 'pub.dev', link: 'https://pub.dev/packages/talker' },
              { text: 'GitHub', link: 'https://github.com/Frezyx/talker' },
              { text: 'Web Demo', link: 'https://frezyx.github.io/talker' },
            ],
          },
        ],
        sidebar: {
          '/ru/': [
            {
              text: 'Начало работы',
              collapsed: false,
              items: [
                { text: 'Установка', link: '/ru/getting-started/installation' },
                { text: 'Быстрый старт', link: '/ru/getting-started/quick-start' },
                { text: 'Почему Talker?', link: '/ru/getting-started/why-talker' },
              ],
            },
            {
              text: 'Основные пакеты',
              collapsed: false,
              items: [
                { text: 'talker', link: '/ru/packages/talker' },
                { text: 'talker_logger', link: '/ru/packages/talker-logger' },
                { text: 'talker_flutter', link: '/ru/packages/talker-flutter' },
              ],
            },
            {
              text: 'Интеграции',
              collapsed: false,
              items: [
                { text: 'Dio Logger', link: '/ru/integrations/dio' },
                { text: 'HTTP Logger', link: '/ru/integrations/http' },
                { text: 'BLoC Logger', link: '/ru/integrations/bloc' },
                { text: 'Riverpod Logger', link: '/ru/integrations/riverpod' },
                { text: 'Chopper Logger', link: '/ru/integrations/chopper' },
                { text: 'gRPC Logger', link: '/ru/integrations/grpc' },
              ],
            },
            {
              text: 'Руководства',
              collapsed: false,
              items: [
                { text: 'Пользовательские логи', link: '/ru/guides/custom-logs' },
                { text: 'Интеграция с Crashlytics', link: '/ru/guides/crashlytics' },
                { text: 'Логирование маршрутов', link: '/ru/guides/routing' },
                { text: 'Кастомные сообщения об ошибках', link: '/ru/guides/custom-error-messages' },
              ],
            },
            {
              text: 'Примеры',
              link: '/ru/examples',
            },
          ],
        },
        outline: { label: 'Содержание' },
        docFooter: { prev: 'Предыдущая', next: 'Следующая' },
        darkModeSwitchLabel: 'Тема',
        sidebarMenuLabel: 'Меню',
        returnToTopLabel: 'Наверх',
        langMenuLabel: 'Язык',
      },
    },
  },

  themeConfig: {
    logo: '/logo.png',
    siteTitle: 'Talker',

    socialLinks: [
      { icon: 'github', link: 'https://github.com/Frezyx/talker' },
    ],

    search: {
      provider: 'local',
    },

    editLink: {
      pattern: 'https://github.com/Frezyx/talker/edit/master/website/docs/:path',
      text: 'Edit this page on GitHub',
    },

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2022-present Stanislav Ilin',
    },
  },
})
