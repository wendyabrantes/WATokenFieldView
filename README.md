# WATokenFieldView
WATokenFieldView is custom view that let you add token view in a view while typing/searching. A similar view is used by facebook application to search for a friend. The component originate from telegram and has been made reusable.

<!--![alt tag](https://raw.githubusercontent.com/gontovnik/DGActivityIndicatorView/master/DGActivityIndicatorView.gif)-->

## Requirements
* Xcode 6 or higher
* Apple LLVM compiler
* iOS 8.0 or higher (May work on previous versions, i just didnt test on it, feel free to edit)
* ARC

## Demo

Open and run the WATokenFieldViewExample project in Xcode to see WATokenFieldView in action. The example show how to filter a table view and add tag of people you want selected.

## Installation

### Cocoapods

Install Cocoapods if it is not installed yet:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Add WATokenFieldView to Podfile:

``` bash
pod 'WATokenFieldView'
```

Call 'pod install':

``` bash
pod install
```

### Manual install

All you need to do is drop WATokenFieldView folder into your project and include headers.

## Example usage

``` objective-c
  WATokenFieldView _tokenFieldView = [[WATokenFieldView alloc]initWithTextColor:[UIColor blackColor]
                                              placeholderColor:[UIColor lightGrayColor]
                                                separatorColor:[UIColor lightGrayColor]
                                             tagHighlightColor:[UIColor blueColor]
                                                 textFieldFont:[UIFont systemFontOfSize:15]
                                              maxNumberOfLines:2];

  _tokenFieldView.delegate = self;
  _tokenFieldView.placeholder = @"enter a name";
```

## Contact

Wendy Abrantes

- https://github.com/wendyabrantes
- https://twitter.com/wendyabrantes
- abranteswendy@gmail.com

## License

The MIT License (MIT)

Copyright (c) 2015 Wendy Abrantes

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
