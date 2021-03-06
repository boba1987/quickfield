import {inlineGroup, blockGroup} from './template'

export default
	fields: null
	style: 'block'
	collapsable: true
	startCollapsed: false
	groupMargin: 10
	groupWidth: '100%'
	autoWidth: true
	autoRemoveEmpty: false
	dynamicLabel: false
	minItems: null
	maxItems: null
	draggable: false
	cloneable: false
	removeable: true
	singleMode: false
	numbering: false
	multiple: true
	dragdrop: true
	groupSettings:
		labelSize: 14
		inline:
			padding: 0
			fieldMargin: 0
			width: 'auto'
			collapsable: false
			startCollapsed: false
			templates: inlineGroup

		block:
			startCollapsed: false
			templates: blockGroup