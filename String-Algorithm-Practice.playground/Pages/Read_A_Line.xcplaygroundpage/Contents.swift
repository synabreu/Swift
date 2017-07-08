// Read a Line 
if let n1 = readLine() {
    if let num = Int(n1) {
        print(num)
    }
}

let prompt1 = readLine()
let prompt2 = readLine()

if let response1 = prompt1,
    let response2 = prompt2,
    let num1 = Int(response1),
    let num2 = Int(response2) {
    
    print("The sum of \(num1) and \(num2) is \(num1 + num2)")
}

