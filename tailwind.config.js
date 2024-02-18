module.exports = {
  purge: ["./templates/**/*.html", "./theme/**/*.html"],
  theme: {
    container: {
      center: true
    },
    screens: {
      'desktop': '1024px',
    }
  },
  variants: {},
  plugins: [
    require('@tailwindcss/typography'),
  ],
};
