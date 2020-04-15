package pilot.wings;

import pilot.VNode;
import pilot.Children;
import pilot.Component;

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

class Form extends Component {

  @:attribute var id:String;
  @:attribute var action:String;
  @:attribute var method:FormMethod = MethodPost;
  @:attribute var enctype:FormEnctype = EnctypeDefault;
  @:attribute var children:Children;
  #if (js && !nodejs)
    @:attribute(optional) var onSubmit:(e:js.html.Event)->Void;
  #else
    @:attribute(optional) var onSubmit:(e:Dynamic)->Void;
  #end

  override function render() return html(
    <form
      id={id}
      action={action}
      method={method}
      enctype={enctype}
      onSubmit={#if (js && !nodejs) onSubmit #else null #end}
    >
      {children}
    </form>
  );

}
