# React Bootstrap (+ Tauri) for VS Code (Windows)

I'm no front end dev, and I can barely play one on TV, so I wrote this quick script to abstract away the few commands required to get setup with [React](https://react.dev/), [Bootstrap](https://react-bootstrap.netlify.app/), and (optionally) [Tauri](https://tauri.app/). It uses [Vite](https://vitejs.dev/) to configure the environment.

Install [npm](https://nodejs.org/en/download) and (optionally) [cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html) before getting started.

Project home is assumed to be the parent of the directory where you clone this repository.

## Usage (in PowerShell):
    git clone https://github.com/yuri-rage/vscode-react-bootstrap.git
    cd vscode-react-bootstrap
    .\react-bootstrap <new project name>

You can also right-click on react-bootstrap.ps1 (or a shortcut to it), and select "Run with PowerShell."  If you have .ps1 files [associated with PowerShell](https://www.top-password.com/blog/set-ps1-script-to-open-with-powershell-by-default/), you can double-click on react-bootstrap.ps1 or a shortcut to it.  In either case, a prompt for a new project name will appear in the window that spawns.

See also: _[My VS Code settings repository](https://github.com/yuri-rage/vscode-configuration)_

---
### License
<small>Copyright &copy; 2023 -- Yuri

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</small>