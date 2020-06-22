Binary Clock
============

Binary clock watch face for Garmin watches.

# Building 

## Generating private keys

The `monkeyc` compiler requries a private key for a compilation.
You may generate one using commands:

```
openssl genrsa -out developer_key.pem 4096
openssl pkcs8 -topk8 -inform PEM -outform DER -in developer_key.pem -out developer_key.der -nocrypt
```

See [here](https://developer.garmin.com/connect-iq/programmers-guide/getting-started#generatingakeyusingopenssl) for details.

## Compiling the project

```
monkeyc -o build/BinaryClock.prg -y developer_key.der -f monkey.jungle -d fenix5x
```

## Starting an emulator

```
connectiq
```

## Running app in emulator

```
monkeydo build/BinaryClock.prg fenix5x
```

# Setting up in VSCode

If you'd rather do coding in VSCode instead of eclipse, you might want to set build tasks:

`.vscode/tasks.json`
```
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Compile",
            "type": "shell",
            "command": "monkeyc -o build/${workspaceFolderBasename}.prg -y .build/key.der -f monkey.jungle -d fenix5x",
            "problemMatcher": [],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        },
        {
            "label": "Start Simulator",
            "type": "shell",
            "command": "connectiq",
            "isBackground": true            
        },
        {
            "label": "Run",
            "type": "shell",
            "command": "monkeydo build/${workspaceFolderBasename}.prg fenix5x",
            "problemMatcher": [],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "dependsOn": ["Compile", "Start Simulator"]
        }
    ]
}
```

# References

[Garmin SDK](https://developer.garmin.com/connect-iq/programmers-guide/)