datasort babel =
 | fizz
 | buzz
 | fizzbuzz
 | number
 
datatype babel(babel) =
 | fizz(fizz)
 | buzz(buzz)
 | fizzbuzz(fizzbuzz)
 | number(number)

dataprop FizzBuzz (int,babel) =
 | {i:int}{res:int} FIZZBUZZ(i,fizzbuzz) of (DIVMOD(i,3,res,0), DIVMOD(i,5,res,0) | int(i), babel(fizzbuzz))
 | {i:int}{res:int} FIZZ(i,fizz) of (DIVMOD(i,3,res,0))
 | {i:int}{res:int} BUZZ(i,buzz) of (DIVMOD(i,3,res,0))
 | {i:int}{res:int} BUZZ(i,number)
 
extern fn calculate_fizzbuzz: {i:int} int(i) -> [b:babel] (FizzBuzz(i,b) | babel(b))
implement calculate_fizzbuzz i =
  if (i mod 3) = 0 && (i mod 5) = 0
    then fizzbuzz