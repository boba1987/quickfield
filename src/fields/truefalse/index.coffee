import extend from 'smart-extend'
import {inheritProto} from '../../helpers'
import SimplyBind from '@danielkalen/simplybind'
import ChoiceField from '../choice'
import Field from '../../field'
import template,* as templates from './template'
import defaults from './defaults'

class TrueFalseField extends Field
	template: template
	templates: templates
	defaults: defaults

	constructor: ()->	
		super(arguments...)
		@lastSelected = null
		@visibleChoicesCount = 2
		@choices = @settings.choices
		@choices[0].label = @settings.choiceLabels[0]
		@choices[1].label = @settings.choiceLabels[1]
		@settings.perGroup = 2
		@_createElements()
		@_attachBindings()
		@_constructorEnd()

	_getValue: ()->
		if @_value is null
			return null
		else
			if @_value.index is 0 then true else false

	_setValue: (newValue)->
		newValue = @choices[0].value if newValue is @choices[0]
		newValue = @choices[1].value if newValue is @choices[1]
		
		if newValue is null
			@_value = null
			@lastSelected?.toggle(off)
			return

		if typeof newValue is 'string'
			newValue = newValue.toLowerCase()
			newValue = false if newValue is 'false'
			
		(if newValue then @choices[0] else @choices[1]).toggle()


	_validate: (providedValue)->
		providedValue = @findChoice(providedValue) if typeof providedValue is 'string'
		
		if @settings.validWhenIsChoice
			if providedValue
				return false if @settings.validWhenIsChoice isnt providedValue.value
			else
				return false

		if @settings.validWhenSelected
			return false if not providedValue

		if @settings.validWhenTrue
			return false if providedValue?.index isnt 0

		return true











inheritProto(TrueFalseField, ChoiceField, [
	'_createElements'
	'_attachBindings'
	'_attachBindings_elState'
	'_attachBindings_stateTriggers'
	'_attachBindings_display'
	'_attachBindings_value'
])





export default TrueFalseField