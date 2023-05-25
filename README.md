# TOP-Mastermind
Mastermind in Ruby


## Rules:
12 attempts to guess a 4 digit code
inform Codebreaker when each digit exists but does not match position
inform Codebreaker when each digit exists and matches position

## Build steps
1. Build the game assuming the computer randomly selects the secret colors and the human player must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!
2. Now refactor your code to allow the human player to choose whether they want to be the creator of the secret code or the guesser.
3. Build it out so that the computer will guess if you decide to choose your own secret colors. You may choose to implement a computer strategy that follows the rules of the game or you can modify these rules.

Bugs:
✅ 0001 - Guess with multiple matches generates extra entries in guess array. Each guess digit must only result in a single 
0002 - ex code 2462: 2462|246?. Guess digit matching earlier in the string will generate a ? regardless of result in current spot.
0003 - ex code 1399: 1123|1?xx. If only one matching digit, dont mismatch if the single match has already been matched.