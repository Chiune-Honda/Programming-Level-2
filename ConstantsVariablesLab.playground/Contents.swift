/*
Welcome to the Constants and Variables Lab!

In this lab, we’ll explore how to use constants and variables in Swift.

- Constants (created with `let`) are values that don’t change.
- Variables (created with `var`) are values that can change.

Let’s dive in! 🚀
*/

// Exercise 1: Declaring a constant
// TODO: Declare a constant called `birthYear` and set it to your birth year.

let birthYear = 2007


// Exercise 2: Declaring a variable
// TODO: Declare a variable called `currentAge` and set it to your current age.

var currentAge = 17

// Exercise 3: Changing the value of a variable
// Imagine you’re a year older. Update `currentAge` to reflect this new age.

currentAge = 10

// Exercise 4: Trying to change a constant
// Uncomment the line below to see what happens when you try to change a constant!
//birthYear += 1 doesnt work because cant change constants
// Q: Why doesn’t this work?

/*
Mini Build: Life Tracker (5 min)

Let’s build a small script that simulates tracking your age over the next few years.
1. Declare a constant for `myBirthYear`.
2. Declare a variable `currentYear` (set it to the current year).
3. Calculate your age by subtracting `myBirthYear` from `currentYear`.
4. Update `currentYear` to simulate each new year, and update your age.

Try adding print statements to track the changes.
*/
let myBirthYear = 2007
var currentYear = 2025


currentYear = 2026

func calculateAge() -> Int{
    return currentYear - myBirthYear
    
}

var age = currentYear - myBirthYear

print(age)


// Increment the year and age to simulate time passing
for i in 1 ... 100000000 {
    currentYear += 1
    print("My age is \(calculateAge())")
}
