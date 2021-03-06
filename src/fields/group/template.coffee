import DOM from 'quickdom'
import COLORS from '../../constants/colors'
import {caretUp, caretDown} from '../../svg'


export action = DOM.template(
	['div'
		events: inserted: ()-> @style('marginLeft', 5) if @index
		style:
			display: 'inline-block'
			boxSizing: 'border-box'
			# verticalAlign: 'middle'

		['div'
			ref: 'icon'
			style:
				width: 17
				height: 17
				color: COLORS.grey
				fill: COLORS.grey
				$hover:
					color: COLORS.grey_dark
					fill: COLORS.grey_dark

		]
	]
)

export collapseIcons = [
	caretUp.extend options: style:
		position: 'relative'
		top: -2
		display: 'none'
		$collapsed: display: 'block'
	
	caretDown.extend options: style:
		display: 'block'
		$collapsed: display: 'none'
]


export default DOM.template(
	['div'
		ref: 'field'
		style:
			position: 'relative'
			boxSizing: 'border-box'
			verticalAlign: 'top'
			display: 'none'
			width: (field)-> field.state.width
			fontFamily: (field)-> field.settings.fontFamily
			# backgroundColor: (field)-> field.settings.color
			border: "1px solid #{COLORS.grey_light}"
			borderRadius: 3
			textAlign: 'left'
			# lineHeight: '1em'
			$visible:
				display: 'inline-block'
			$showError: $collapsed:
				animation: '0.2s fieldErrorShake'

		['div'
			ref: 'label'
			style:
				display: 'none'
				fontFamily: 'inherit'
				fontSize: (field)-> field.settings.labelSize
				fontWeight: 600
				textAlign: 'left'
				color: COLORS.black
				cursor: 'default'
				userSelect: 'none'
				$showLabel:
					display: 'block'
				$showError:
					color: COLORS.red
		]

		['div'
			ref: 'actions'
			style:
				position: 'absolute'
				top: (field)-> (field.settings.padding * (12/20))
				right: (field)-> (field.settings.padding * (12/20))
				lineHeight: 0
				fontSize: 0
				textAlign: 'center'
				$showLabel:
					top: (field)-> (field.settings.padding * (21/20))
		]

		['div'
			ref: 'help'
			style:
				marginTop: '10px'
				fontFamily: 'inherit'
				fontSize: '11px'
				color: COLORS.grey
				display: 'none'
				whiteSpace: 'pre-line'
				$showError:
					color: COLORS.red
					display: 'block'
				$showHelp:
					display: 'block'
		]
		
		['div'
			ref: 'innerwrap'
			unpassableStates: ['visible','hover','focus','disabled','showLabel','showError','showHelp','collapsed','valid','invalid']
			style:
				position: 'relative'
				boxSizing: 'border-box'
				marginTop: 15
				fontFamily: 'inherit'
				textAlign: 'justify'
				textJustify: 'distribute-all-lines'
				fontSize: 0
				$collapsed:
					display: 'none'
		]
	]
)











