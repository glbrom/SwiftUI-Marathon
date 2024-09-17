# SwiftUI-Marathon

> Week 1. Days 16-25: Starting SwiftUI and creating 4 apps

<img src="https://github.com/glbrom/SwiftUI-Marathon/blob/638178ea0dde7ca7d335c377fd1b13bfb8851d76/Assets/Week%201/WeSplit.png" width="190">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/glbrom/SwiftUI-Marathon/blob/638178ea0dde7ca7d335c377fd1b13bfb8851d76/Assets/Week%201/Length%20Converter.png" width="190">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/glbrom/SwiftUI-Marathon/blob/8541e9f147cb4ebb4e310bc267c32ab3e1274cd6/Assets/Week%201/Guess%20the%20Flag.png" width="190">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/glbrom/SwiftUI-Marathon/blob/638178ea0dde7ca7d335c377fd1b13bfb8851d76/Assets/Week%201/PRS.png" width="190">

### Challenge WeSplit
- [x] Add a header to the third section, saying “Amount per person”
- [x] Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.
- [x] Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.
- [x] Use a conditional modifier to change the total amount text view to red if the user selects a 0% tip. 

### Challenge Length Converter
> You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.

> Which units you choose are down to you, but you could choose one of these:
- Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
- Length conversion: users choose meters, kilometers, feet, yards, or miles.
- Time conversion: users choose seconds, minutes, hours, or days.
- Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
> If you were going for length conversion you might have:
- [x] A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
- [x] A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
- [x] A text field where users enter a number.
- [x] A text view showing the result of the conversion.

### Challenge Guess the Flag
- [x] Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert and in the score label.
- [x] When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
- [x] Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.
- [x] Replace the Image view used for flags with a new FlagImage() view that renders one flag image using the specific set of modifiers we had.
- [x] Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.

### Challenge Rock Paper Scissors
> Your challenge is to make a brain training game that challenges players to win or lose at rock, paper, scissors.
- [x] Each turn of the game the app will randomly pick either rock, paper, or scissors.
- [x] The player must then tap the correct move to win or lose the game.
- [x] If they are correct they score a point; otherwise they lose a point.
- [x] The game ends after 10 questions, at which point their score is shown.
