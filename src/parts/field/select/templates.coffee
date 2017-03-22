{
	field: DOM.template ['div', {
		style: extend.clone TextField::_templates.field.options.style
	}]


	fieldInnerwrap: DOM.template ['div', {
		style: extend.clone TextField::_templates.fieldInnerwrap.options.style
	}]


	label: DOM.template ['div', {
		style: extend.clone TextField::_templates.label.options.style
	}]


	input: DOM.template ['div', {
		props:
			tabIndex: 0
		style: extend.clone TextField::_templates.input.options.style,
			userSelect: 'none'
	}]


	placeholder: DOM.template ['div', {
		style: extend.clone TextField::_templates.placeholder.options.style
	}]


	caret: DOM.template ['div', {
		style:
			position: 'relative'
			zIndex: 3
			top: (field)-> parseFloat(field.els.input.style('height'))/2 - 17/2
			display: 'inline-block'
			# width: '17px'
			width: '29px'
			height: '17px'
			paddingRight: '12px'
			boxSizing: 'border-box'
			verticalAlign: 'top'
			outline: 'none'
	}, SVG.angleDown]
			pointerEvents: 'none'


	help: DOM.template ['div', {
		style: extend.clone TextField::_templates.help.options.style
	}]
}












