/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';

	config.font_names = CKEDITOR.config.font_names = '맑은 고딕/Malgun Gothic;굴림/Gulim;돋움/Dotum;바탕/Batang;궁서/Gungsuh;' + CKEDITOR.config.font_names;
	config.enterMode = CKEDITOR.ENTER_BR;
	config.height = '500px';
	
	config.extraPlugins = 'filetools,uploadimage,uploadwidget,locationmap,widget,widgetselection,notificationaggregator,lineutils,notification,toolbar,clipboard';
	
//	config.imageUploadUrl = '../creation/rest/uploadFileDragAndDrop';
	config.filebrowserImageUploadUrl = 'uploadCKEditorFile';
//	config.filebrowserUploadUrl = '../booklog/rest/uploadFile';
		
	config.toolbarGroups = [
		{ name: 'insert', groups: [ 'insert' ] },
		{ name: 'links', groups: [ 'links' ] },
		{ name: 'tools', groups: [ 'tools' ] },
		{ name: 'clipboard', groups: ['clipboard' , 'undo' ] },
		{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
		{ name: 'forms', groups: [ 'forms' ] },
		{ name: 'about', groups: [ 'about' ] },
		'/',
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
		'/',
		{ name: 'styles', groups: [ 'styles' ] },
		{ name: 'colors', groups: [ 'colors' ] },
		{ name: 'document', groups: [ 'document', 'doctools', 'mode' ] },
		{ name: 'others', groups: [ 'others' ] },
	];

	config.removeButtons = 'Save,NewPage,Preview,Link,Unlink,About,RemoveFormat,CopyFormatting,PageBreak,Flash,Superscript,Subscript,Radio,Form,Checkbox,TextField,Textarea,Select,Button,ImageButton,HiddenField,CreateDiv,Print,Paste,Copy';

};
