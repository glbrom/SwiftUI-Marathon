# SwiftUI-Marathon

> Week 5. Days 43-52: Scaling up to bigger apps and focus on data

<img src="https://github.com/glbrom/SwiftUI-Marathon/blob/fd721e825f11d29d10a14ddbfe75d99689ad250f/Assets/Week%205/HabitTracking.png" width="190">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/glbrom/SwiftUI-Marathon/blob/83cb9459d690723cb5c86d5774f7df8513c0b523/Assets/Week%205/CupcakeCorner.png" width="190">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

### Challenge Habit Tracking
- [x] This time your goal is to build a habit-tracking app, for folks who want to keep track of how much they do certain things. That might be learning a language, practicing an instrument, exercising, or whatever – they get to decide which activities they add, and track it however they want.
At the very least, this means there should be a list of all activities they want to track, plus a form to add new activities – a title and description should be enough.
For a tough challenge make that detail screen contain how many times they have completed it, plus a button incrementing their completion count.

### Challenge Cupcake Corner
- [x] Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
- [x] If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
- [x] For a more challenging task, try updating the Order class so it saves data such as the user's delivery address to UserDefaults. This takes a little thinking, because @AppStorage won't work here, and you'll find getters and setters cause problems with Codable support.
