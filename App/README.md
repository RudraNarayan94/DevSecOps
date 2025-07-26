# Currency Converter 🌍💸

Allows to convert amounts between different currencies using a clean and intuitive interface. This project is built with **React**, utilizes custom hooks, and is styled with **Tailwind CSS**.

## 🌟 Features

- **Real-Time Currency Conversion**: Converts values based on the selected currency pair.
- **Swap Functionality**: Quickly switch between "From" and "To" currencies.

## 🛠️ Built With

- **React**: Front-end library for building the user interface.
- **Tailwind CSS**: For styling the components and layout.
- **Custom Hooks**: `useCurrency` hook for fetching and managing currency data.

## 🚀Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/RudraNarayan94/Currency-Converter--React.git
   ```
2. Install dependencies:
   ```bash
   npm install
   ```

### Running the App

Start the development server:

```bash
npm run dev
```

Open your browser and go to [http://localhost:5173](http://localhost:5173) to see the application in action.

### Building for Production

## 🛠️ Custom Hooks

The project uses a custom `useCurrency` hook:

```js
const currencyInfo = useCurrency(from);
```

- This hook fetches exchange rates based on the selected currency and returns an object with conversion rates .

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📬 Contact

Feel free to reach out for any questions or feedback:

- **GitHub**: [yourusername](https://github.com/RudraNarayan94)

---

Happy coding! 🎉
