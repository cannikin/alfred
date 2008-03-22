var project_blocks = {
	
	UPDATE_URL:'/utility/get_state',
	START_URL:'/utility/start_project',
	STATES:['running','stopped','starting','error'],
	
	// toggle the element's description
	toggle_description:function(id) {
		var obj = this.elementize(id);
		$($(obj).id+'_description').toggle();
	},

	// change the status of the project
	start_status_polling:function(id,interval,display) {
		var obj = this.elementize(id);
		var self = this;
		
		new Ajax.PeriodicalUpdater(	'',
																this.UPDATE_URL + '/' + id + '?display=' + display,
																{ frequency:interval,
																	onSuccess:function(response) {
																		self.update_state(obj,response.responseText);
																	}
																}
															);
	},
	
	start:function(id) {
		var obj = this.elementize(id);
		var self = this;
		this.update_state(obj,'starting');
		
		new Ajax.Request(	this.START_URL + '/' + id,
											{ onSuccess:function(response) {
													self.update_state(obj,response.responseText);
												}
											}
										);
	},
	
	update_state:function(obj,new_state) {
		this.STATES.each(function(state) {
			obj.removeClassName(state);
		});
		obj.addClassName(new_state);
	},

	// turn an id into an element reference
	elementize:function(id) {
		return $('project_'+id);
	}

}

var settings_blocks = {
	
	// get the server's hostname
	get_hostname:function(obj) {
		new Ajax.Request(	'/utility/hostname',
											{ asynchronous:true,
												onSuccess:function(response) {
													$(obj).value = response.responseText
												},
												onFailure:function(response) {
													$(obj).value = 'unknown'
												}
											});
	}
}