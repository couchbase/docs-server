function sumListOfNumbers(... args) {    // <.>
    
    var sum = 0;
    
    args.forEach(value => sum = sum  + value);    // <.>
    
    return sum;
    
}

