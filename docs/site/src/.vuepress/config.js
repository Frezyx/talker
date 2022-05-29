const { description } = require('../../package')

module.exports = {
  /**
   * Ref：https://v1.vuepress.vuejs.org/config/#title
   */
  title: 'Talker',
  /**
   * Ref：https://v1.vuepress.vuejs.org/config/#description
   */
  description: description,

  /**
   * Extra tags to be injected to the page HTML `<head>`
   *
   * ref：https://v1.vuepress.vuejs.org/config/#head
   */
  head: [
    ['meta', { name: 'theme-color', content: '#3EE99F' }],
    ['meta', { name: 'apple-mobile-web-app-capable', content: 'yes' }],
    ['meta', { name: 'apple-mobile-web-app-status-bar-style', content: 'black' }],
    ['link', { rel: "icon", href: "/favicons/favicon.svg" }],
    [
      "link",
      {
        rel: "icon",
        type: "image/png",
        sizes: "256x256",
        href: `/favicon/favicon-256x256.png`,
      },
    ],
    ['link', { rel: "shortcut icon", href: "favicons/favicon.ico" }],
    [
      "link",
      {
        rel: "stylesheet",
        href: "https://fonts.googleapis.com/css2?family=Montserrat:wght@800&display=swap",
      },
    ],
  ],

  /**
   * Theme configuration, here is the default theme configuration for VuePress.
   *
   * ref：https://v1.vuepress.vuejs.org/theme/default-theme-config.html
   */
  themeConfig: {
    logo: 'favicons/favicon.svg',
    repo: '',
    editLinks: false,
    docsDir: '',
    editLinkText: '',
    lastUpdated: false,
    nav: [
      {
        text: 'Guide',
        link: '/guide/',
      },
      {
        text: 'pub.dev',
        link: 'https://pub.dev/packages/talker'
      },
      {
        text: 'GitHub',
        link: 'https://github.com/Frezyx/talker'
      }
    ],
    sidebar: {
      '/guide/': [
        {
          title: 'Guide',
          collapsable: false,
          children: [
            '',
            'get-started',
          ]
        },
        {
          title: 'Documentation',
          collapsable: false,
          children: [
            'customization',
            'talker',
            'talker-flutter',
            'talker-logger',
          ]
        },
        {
          title: 'Examples',
          collapsable: false,
          children: [
            'examples',
          ]
        }
      ],
    }
  },

  /**
   * Apply plugins，ref：https://v1.vuepress.vuejs.org/zh/plugin/
   */
  plugins: [
    '@vuepress/plugin-back-to-top',
    '@vuepress/plugin-medium-zoom',
  ]
}
