# V Respawn

Respawn a program after it gets killed

## Usage

```
respawn --program example --max-retry 2 --retry-time 3 --args "-n Ed Edd Eddy"
```

## Arguments

### ```--program``` or ```-p``` (mandatory)

Path to the program to respawn after it gets killed.

### ```--args``` or ```-a``` (optional)

Arguments to be passed to the program. The arguments must be enclosed in single or double quotes.

### ```--work-folder``` or ```-f``` (optional)

Path to the work folder for the program. If omitted, the value will be the current directory.

### ```--max-retry``` or ```-r``` (optional)

Number of times to respawn the program. If omitted, the value will be 3.

### ```--retry-time``` or ```-t``` (optional)

Time in seconds between each respawn. If omitted, the value will be 0.

## Development dependencies

- v
- make (optional)
- MinGW-w64 (optional, for windows cross compilation)

## Licence

BSD-3-Clause
