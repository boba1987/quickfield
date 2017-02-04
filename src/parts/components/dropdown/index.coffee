Dropdown = (@options, @field)->
	@isOpen = false
	@settings = extend.deep.clone.keys(@_defaults).filter(@_settingFilters)(@_defaults, @field.options.dropdownOptions)
	@selected = if @settings.multiple then [] else null
	@lastSelected = null
	@els = {}
	
	for name of @options.templates
		@options.templates[name] = extend(options:{relatedInstance:@}, @options.templates[name])

	@_createElements()
	@_attachBindings()
	return @

Dropdown::_templates = import './templates'
Dropdown::_defaults = import './defaults'
Dropdown::_settingFilters = maxHeight: (value)-> IS.number(value)

Dropdown::_createElements = ()->
	@els.container = @_templates.container.spawn(@settings.templates.container)
	@els.list = @_templates.list.spawn(@settings.templates.list).appendTo(@els.container)
	@els.help = @_templates.help.spawn(@settings.templates.help).appendTo(@els.container)

	@options.forEach (option)=>
		option.el = @_templates.option.spawn(options:{props:'title':option.label}, children:[option.label]).appendTo(@els.list)
		option.visible = true
		option.selected = false
		option.unavailable = false

	return



Dropdown::_attachBindings = ()->
	if @field.type is 'select'
		SimplyBind('event:click', listenMethod:'on').of(@field.els.input)
			.to ()=>
				@isOpen = true
				SimplyBind('event:click').of(document)
					.once.to ()=> @isOpen = false
					.condition (event)=> not DOM(event.target).parentsMatching (parent)=> parent is @field.els.input

	SimplyBind('help').of(@settings.text)
		.to('textContent').of(@els.help.raw)
		.and.to (showHelp)=> @els.help.state 'showHelp', showHelp


	SimplyBind('isOpen', updateOnBind:false).of(@)
		.to (isOpen)=> @els.container.state 'isOpen', isOpen		
		.and.to (isOpen)=> if isOpen
			targetMaxHeight = @settings.maxHeight
			clippingParent = @els.container.parentMatching (parent)-> parent.style('overflow') isnt 'visible'
		
			if clippingParent
				selfRect = @els.container.rect
				clippingRect = clippingParent.rect
				cutoff = (selfRect.top + @settings.maxHeight) - clippingRect.bottom

				if selfRect.top >= clippingRect.bottom
					console.warn("The dropdown for element '#{@field.ID}' cannot be displayed as it's hidden by the parent overflow")
				else if cutoff > 0
					padding = selfRect.height - @els.list.rect.height
					targetMaxHeight = cutoff - padding
			
			@els.list.style 'maxHeight', targetMaxHeight
			@els.list.style 'minWidth', parseFloat(@field.els.input.style('width'))+10


	SimplyBind('lastSelected', updateOnBind:false).of(@)
		.to (newOption, prevOption)=>
			if @settings.storeSelected
				newOption.selected = true
				prevOption.selected = false if prevOption
				
				if @settings.multiple
					@selected.push(newOption)
					helpers.removeItem(@selected, prevOption)
				else
					@selected = newOption
			
			@selectedCallback(newOption, prevOption)


	@options.forEach (option)=>	
		SimplyBind('visible').of(option)
			.to (visible)-> option.el.state 'visible', visible

		SimplyBind('selected', updateOnBind:false).of(option)
			.to (selected)-> option.el.state 'selected', selected
		
		SimplyBind('unavailable').of(option)
			.to (unavailable)-> option.el.state 'unavailable', unavailable
			.and.to ()=> option.selected = false; @selected = null
				.condition (unavailable)=> unavailable and @settings.multiple and option.selected

		SimplyBind('event:click', listenMethod:'on').of(option.el)
			.to ()=> @lastSelected = option

		if @field.type is 'text'
			SimplyBind('value').of(@field)
				.to('visible').of(option)
					.transform (fieldValue)-> if not value then true else helpers.fuzzyMatch(option.value, fieldValue)
					.condition ()=> @isOpen

		if option.conditions?.length
			option.unavailable = true
			option.allFields = @field.allFields

			helpers.initConditions option, option.conditions, ()=>
				option.unavailable = !helpers.validateConditions(option.conditions)


Dropdown::appendTo = (target)->
	@els.container.appendTo(target)


Dropdown::onSelected = (callback)->
	@selectedCallback = callback













