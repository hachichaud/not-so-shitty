module.exports.config =
  framework: 'cucumber'

  specs: [
    'features/*.feature'
  ]

  capabilities:
    browserName: process.env.BROWSER || 'chrome'

  seleniumAddress: process.env.SELENIUM || null
