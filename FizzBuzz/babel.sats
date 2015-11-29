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

dataprop FizzBuzz (i:int,babel) =
 | FIZZBUZZ(i,fizzbuzz) of (MOD(i,3,0), MOD(i,5,0))
 | FIZZ(i,fizz) of (MOD(i,3,0))
 | BUZZ(i,buzz) of (MOD(i,5,0))
 | NUM(i,number)

fn calculate_fizzbuzz: {i:nat} lint(i) -> [b:babel] (FizzBuzz(i,b) | babel(b))
fn show_fizzbuzz: {i:nat} int(i) -> string = "mac#"