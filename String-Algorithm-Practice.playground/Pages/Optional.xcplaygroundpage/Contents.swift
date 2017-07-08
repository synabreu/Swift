// Optional --> if the optional value is nil, the conditial is false. 
// optionalString: String? (nil, optional value) = "Hello" -> default value

var optionalString: String? = "Hello"
print(optionalString == nil)

var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello,\(name)"
}

