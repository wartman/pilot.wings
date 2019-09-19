package pilot.wings;

import pilot.VNode;
import pilot.Children;

enum abstract FormMethod(String) to String {
  var MethodPost = 'post';
  var MethodGet = 'get';
  // var MethodPut = 'put';
}

enum abstract FormEnctype(String) to String {
  var EnctypeTextPlain = 'text/plain';
  var EnctypeMultipart = 'multipart/form-data';
  var EnctypeDefault = 'application/x-www-form-urlencoded';
}

abstract Form(VNode) to VNode {

  public inline function new(props:{
    id:String,
    action:String,
    ?method:FormMethod,
    ?enctype:FormEnctype,
    children:Children,
    #if js
      ?onSubmit:(e:js.html.Event)->Void,
    #end
  }) {
    if (props.method == null) props.method = MethodPost;
    if (props.enctype == null) props.enctype = EnctypeDefault;
    this = new VNode({
      name: 'form',
      props: {
        id: props.id,
        action: props.action,
        name: props.id,
        method: props.method,
        enctype: props.enctype,
        #if js
          onSubmit: props.onSubmit
        #end
      },
      children: props.children
    });
  }

}
