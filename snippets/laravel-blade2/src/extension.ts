import * as vscode from 'vscode';
const Beautifier = require('js-beautify').html;

// function bladeBeautifier(html_source: any, options: any) {
// 	//Wrapper function to invoke all the necessary constructors and deal with the output.
//     html_source = html_source || '';

//     // BEGIN
//     html_source = html_source.replace(/\{\{((?:(?!\}\}).)+)\}\}/g, function (m: any, c: any) {
//         if (c) {
//             c = c.replace(/(^[ \t]*|[ \t]*$)/g, '');
//             c = c.replace(/'/g, '&#39;');
//             c = c.replace(/"/g, '&#34;');
//             c = encodeURIComponent(c);
//         }
//         return "{{" + c + "}}";
// 	});
	
//     html_source = html_source.replace(/^[ \t]*@([a-z]+)([^\r\n]*)$/gim, function (m: any, d: any, c: any) {
// 		var ce = c;
		
//         if (ce) {
//             ce = ce.replace(/'/g, '&#39;');
//             ce = ce.replace(/"/g, '&#34;');
//             ce = "|" + encodeURIComponent(ce);
// 		}
		
//         switch (d) {
//             case 'break':
//             case 'case':
//             case 'continue':
//             case 'csrf':
//             case 'else':
//             case 'elseif':
//             case 'empty':
//             case 'extends':
//             case 'include':
//             case 'includeFirst':
//             case 'includeIf':
//             case 'includeWhen':
//             case 'inject':
//             case 'json':
//             case 'method':
//             case 'parent':
//             case 'stack':
//             case 'yield':
//                 return "<blade " + d + ce + "/>";
//             case 'section':
//                 if(c.match(/[ \t]*\([ \t]*['"][^'"]*['"][ \t]*\)/i)){
//                    return "<blade " + d + ce + ">";
//                 } else {
//                    return "<blade " + d + ce + "/>";
//                 }
//             case 'show':
//             case 'stop':
//                 return "</blade " + d + ce + ">";
//             default:
//                 if (d.startsWith('end')) {
//                     return "</blade " + d + ce + ">";
//                 } else {
//                     return "<blade " + d + ce + ">";
//                 }
//         }
//     });
//     // END

// 	var sweet_code = Beautifier(html_source, options);
    
//     // BEGIN
//     sweet_code = sweet_code.replace(/^([ \t]*)<\/?blade ([a-z]+)\|?([^>\/]+)?\/?>$/gim, function (m: any, s: any, d: any, c: any) {
//         if (c) {
//             c = decodeURIComponent(c);
//             c = c.replace(/&#39;/g, "'");
//             c = c.replace(/&#34;/g, '"');
//             c = c.replace(/^[ \t]*/g, '');
//         } else {
//             c = "";
//         }
//         if (!s) {
//             s = "";
//         }
//         return s + "@" + d + c;
//     });

//     sweet_code = sweet_code.replace(/\{\{((?:(?!\}\}).)+)\}\}/g, function (m: any, c: any) {
//         if (c) {
//             c = decodeURIComponent(c);
//             c = c.replace(/&#39;/g, "'");
//             c = c.replace(/&#34;/g, '"');
//             c = c.replace(/(^[ \t]*|[ \t]*$)/g, ' ');
//         }
//         return "{{" + c + "}}";
//     });
//     // END

//     return sweet_code;
// }

const editor = vscode.workspace.getConfiguration('editor');
const config = vscode.workspace.getConfiguration('blade');

function beautify(document: vscode.TextDocument, range: vscode.Range) {
    const result = [];
    let output = '';
    let options = Beautifier.defaultOptions;

    options.indent_size = editor.tabSize;
    options.end_with_newline = config.newLine;
    
    options.indent_char = ' ';
    options.extra_liners = [];
    options.brace_style = 'collapse';
    options.indent_scripts = 'normal';
    options.space_before_conditional = true;
    options.keep_array_indentation = false;
    options.break_chained_methods = false;
    options.unescape_strings = false;
    options.wrap_line_length = 0;
    options.jslint_happy = false;
    options.comma_first = true;
    options.e4x = true;

    output = Beautifier(document.getText(range), options);

    result.push(vscode.TextEdit.replace(range, output));

    return result;
}


function activate(context: vscode.ExtensionContext) {
	console.log('Laravel blade activated!');

	const LANGUAGES = { scheme: 'file', language: 'blade' };

	if (config.format.enable === true) {
		context.subscriptions.push(
			vscode.languages.registerDocumentFormattingEditProvider(LANGUAGES, {
				provideDocumentFormattingEdits(document: vscode.TextDocument) {
					const start = new vscode.Position(0, 0);
					const end = new vscode.Position(
						document.lineCount - 1,
						document.lineAt(document.lineCount -1).text.length
					);
					const rng = new vscode.Range(start, end);

					return beautify(document, rng);
				}
			})
		);

		context.subscriptions.push(
			vscode.languages.registerDocumentRangeFormattingEditProvider(LANGUAGES, {
					provideDocumentRangeFormattingEdits(document: vscode.TextDocument, range: vscode.Range) {
						let end = range.end

						if (end.character === 0) {
							end = end.translate(-1, Number.MAX_VALUE);
						} else {
							end = end.translate(0, Number.MAX_VALUE);
						}

						const rng = new vscode.Range(new vscode.Position(range.start.line, 0), end)

						return beautify(document, rng);
					}
				}
			)
		)
	}
}

function deactivate() {}

export {
	activate,
	deactivate,
}
