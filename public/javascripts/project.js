var Project = new Class.create();

Project.prototype = {

	initialize:function(obj) {

		// extended the passed object with this class
		Object.extend(obj, this);
		return obj;
	},

	toggleDescription:function() {
		$(this.name+'_description').toggle();
	}

}

var Project2 = {
	toggleDescription:function() {
		$(this.name+'_description').toggle();
	}
}