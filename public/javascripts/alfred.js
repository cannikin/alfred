var project_blocks = {
	
	UPDATE_URL:'/utility/get_state',
	START_URL:'/utility/start_project',
	STOP_URL:'/utility/stop_project',
	CLEAR_URL:'/utility/clear_project',
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
									{	frequency:interval,
										onSuccess:function(response) {
											self.update_state(obj,response.responseText.evalJSON());
										}
									}
								);
	},
	
	start:function(id) {
		var obj = this.elementize(id);
		var self = this;
		this.update_state(obj, {class:'starting',button:{value:'Starting...',disabled:'disabled'}});
		
		new Ajax.Request(	this.START_URL + '/' + id,
							{	onSuccess:function(response) {
									self.update_state(obj,response.responseText.evalJSON());
								}
							}
						);
	},

	stop:function(id) {
		var obj = this.elementize(id);
		var self = this;
		this.update_state(obj, {class:'starting',button:{value:'Stopping...',disabled:'disabled'}});
		new Ajax.Request(	this.STOP_URL + '/' + id,
							{	onSuccess:function(response) {
									self.update_state(obj,response.responseText.evalJSON());
								}
							}
						);
	},

	restart:function(id) {
		this.start(id);
	},

	clear:function(id) {
		var obj = this.elementize(id);
		var self = this;
		new Ajax.Request(	this.CLEAR_URL + '/' + id,
							{	onSuccess:function(response) {
									self.update_state(obj,response.responseText.evalJSON());
								}
							}
						);
	},
		
	update_state:function(obj,new_state) {
		//alert(new_state);

		// update class
		this.STATES.each(function(state) {
			obj.removeClassName(state);
		});
		obj.addClassName(new_state.class);
		
		// update button
		var id = obj.id.split('_').last();
		var html = '<input type="button" ';
		for(key in new_state.button) {
			html += key + '="' + new_state.button[key].gsub(/__id__/,id) + '" ';
		}
		html += '/>';

		// add notes about current state, if any
		if(new_state.notes) {
			html += '<p>' + new_state.notes + ' <a href="#" onclick="project_blocks.clear(' + id + '); return false;">clear</a></p>';
		}

		// update project
		$('project_'+id+'_form').update(html);
	},

	update_button:function(id,properties) {
		var output = '<input type="button" ';
		for(key in properties) {
			output += key + '="' + properties[key].gsub(/__id__/,id) + '" ';
		}
		output += '/>';
		$('project_'+id+'_form').update(output);
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