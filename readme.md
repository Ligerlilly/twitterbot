**TwitterBot**

*created Sept 4, 2015*

**Created by: Jason Lane, Tim Kellogg, Jing Wait, Tony Navarro**

*About This App*
~~~~
This app makes use of Twitter and Google's API. We've built this site with the
purpose of searching Twitter for data, displaying it, and searching within that
data.

This site comes with a built in example(?) with searching for the upcoming 2016
election. We got our bulk data from the two search queries, "election" and
"president". Then, within that data, we made a manual search (we search by
first name, last name, and both first and last) for each candidate using recent
polling data (4 democrats and 6 republicans) and saw who was talked about the
most in our batch twitter data.
~~~~

**How to use this app**

git clone from `https://github.com/timkellogg/twitterbot`
install the gems using <code>bundle</code>
start postgres in your CLI
create your database schema with the line <code>rake db:setup</code>
start the local server with the command <code>shotgun</code>
go to your browser `http://localhost:9393`
enjoy!


**Copyright**
The MIT License (MIT)

Copyright (c) 2015 Jason Lane, Tim Kellogg, Jing Wait, Tony Navarro

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
