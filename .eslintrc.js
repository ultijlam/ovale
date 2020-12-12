// eslint-disable-next-line no-undef
module.exports = {
    env: {
        browser: true,
        es2021: true,
    },
    extends: ["eslint:recommended", "plugin:@typescript-eslint/recommended"],
    parser: "@typescript-eslint/parser",
    parserOptions: {
        ecmaVersion: 12,
        sourceType: "module",
        project: "tsconfig.json",
    },
    plugins: ["@typescript-eslint"],
    rules: {
        "@typescript-eslint/explicit-module-boundary-types": "off",
        "@typescript-eslint/no-empty-function": "off",
        "no-constant-condition": "off",
        "@typescript-eslint/no-this-alias": "off",
        "no-empty-pattern": "off",
        "prefer-const": "off",

        // "@typescript-eslint/strict-boolean-expressions": [
        //     2,
        //     { allowNullableObject: true, allowNullableBoolean: true },
        // ],

        // Stylistics
        "quote-props": ["error", "as-needed"],

        // TODO enable these
        "@typescript-eslint/no-unused-vars": "off",
        "@typescript-eslint/no-explicit-any": "off",
    },
};
