function outString = stringComparisonFunction(baseString,breakFlag)


if sum(baseString == '-') > 1 | breakFlag
    dashIdx = find(baseString == '-' , 1, 'first');
    breakIdx = find(baseString(dashIdx:end) == '_', 1, 'first');
    outString = baseString(1:(breakIdx+dashIdx-2) );
else
   outString = strtok(baseString,'_');
end