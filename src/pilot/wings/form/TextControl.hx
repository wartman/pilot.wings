package pilot.wings.form;

#if js
  import js.html.Event;
  import js.html.KeyboardEvent;
  import js.html.InputElement;
#end

enum abstract TextControlType(String) to String {
  var Text = 'text';
  var Email = 'email';
  var Password = 'password';
}

class TextControl extends Component {
  
  @:attribute var type:TextControlType = Text;
  @:attribute var id:String;
  @:attribute var label:String;
  @:attribute var value:String;
  @:attribute(optional) var placeholder:String;
  @:attribute(optional) var required:Bool;
  @:attribute(optional) var onCommit:(value:String)->Void;
  @:attribute(optional) var onChange:(value:String)->Void;
  #if js
    @:attribute(optional) var onBlur:(e:Event)->Void;
    @:attribute(optional) var onClick:(e:Event)->Void;
  #end

  override function render() return html(<>
    <label for={id}>{label}</label>
    <input
      id={id}
      type={type}
      placeholder={placeholder}
      required={required}
      value={value}
      onBlur={#if (js && !nodejs) onBlur #else null #end}
      onClick={#if (js && !nodejs) onClick #else null #end}
      onChange={
        #if (js && !nodejs)
          onChange != null ? (e:Event) -> {
            var input:InputElement = cast e.target;
            onChange(input.value);
          } : null
        #else
          null
        #end
      }
      onKeyup={
        #if (js && !nodejs)
          onCommit != null ? (e:KeyboardEvent) -> {
            if (e.key == 'Enter') {
              var input:InputElement = cast e.target;
              onCommit(input.value);
            }
          } : null
        #else
          null
        #end
      }
    />
  </>);

}
