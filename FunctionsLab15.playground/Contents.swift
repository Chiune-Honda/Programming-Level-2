/*
A function is a reusable block of code that performs a specific task.
You define a function once, and you can call it as many times as you need.

Here's the basic structure of a function:
*/

func greet() {
    print("Hello, World!")
}

/*
In this example:
- `func` is the keyword to define a function.
- `greet` is the function name.
- `{}` is where you place the code that the function will execute.

To call the function, you simply use the function's name followed by parentheses:
*/

greet()  // This will print: "Hello, World!"


/*
Sometimes, you want to pass information into a function.
That's where parameters come in. Parameters are like placeholders that let you pass in data.

Let’s define a function that takes a name as a parameter:
*/

func greet(name: String) {
    print("Hello, \(name)!")
}

// Call the function and pass in a value for the parameter:
greet(name: "Alice")  // This will print: "Hello, Alice!"


/*
Functions can also return a value. For example, let's define a function that adds two numbers together and returns the result.

Here’s how you can define a function with a return value:
*/

func addNumbers(a: Int, b: Int) -> Int {
    return a + b
}

// Calling the function and using the returned value:
let sum = addNumbers(a: 10, b: 5)
print(sum)  // This will print: 15


//Now it's your turn! Create a function that:
//- Takes two numbers as parameters.
//- Returns the product of those two numbers.

func multiplynumbers(a: Int, b: Int) -> Int {
    return a * b
}
print(multiplynumbers(a: 5, b: 5))

//Example:
//Create a function called `multiplyNumbers` that multiplies two numbers and returns the result.
//*/

func multiplyNumbers(a: Int, b: Int) -> Int {
    return a * b
}
print(multiplyNumbers(a: 5, b: 5))


// Test your function:


//Now try creating a few more functions of your own!
//- Create a function that takes two numbers and returns their difference.
//- Create a function that takes a string and prints a personalized greeting.

func differenceInNumbers(z: Int, x: Int) -> Int {
    return z - x
}
print(differenceInNumbers(z: 2, x: 5))

func sayHello(name: String) {
    print("What's good my guy \(name)")
}

sayHello(name: "Jason")
