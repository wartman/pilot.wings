package pilot.wings;

import pilot.VNode;
import pilot.Style;
#if js
  import js.html.Event;
  import js.html.KeyboardEvent;
  import js.html.InputElement;
#end

enum abstract InputType(String) to String {
  var Text = 'text';
  var Password = 'password';
}

// Todo: offer an API for a lot of the functionality
//       listed here: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input
//       -- especially think about validation.
abstract Input(VNode) to VNode {
  
  public inline function new(props:{
    ?name:String,
    ?style:Style,
    ?type:InputType,
    ?placeholder:String,
    ?required:Bool,
    ?disabled:Bool,
    value:String,
    #if js
      ?onCommit:(value:String)->Void,
      ?onChange:(value:String)->Void,
      ?onBlur:(e:Event)->Void,
      ?onClick:(e:Event)->Void,
    #end
  }) {
    this = new VNode({
      name: 'input',
      style: props.style,
      props: {
        type: props.type == null
          ? Text
          : props.type,
        value: props.value,
        placeholder: props.placeholder,
        required: props.required,
        disabled: props.disabled,
        #if js
          onKeyup: props.onCommit != null
            ? (e:Event) -> {
              var e:KeyboardEvent = cast e;
              if (e.key == 'Enter') {
                var input:InputElement = cast e.target;
                props.onCommit(input.value);
              }
            } : null,
          onBlur: props.onBlur,
          onChange: props.onChange != null
            ? (e:Event) -> {
              var e:KeyboardEvent = cast e;
              if (e.key == 'Enter') {
                var input:InputElement = cast e.target;
                props.onChange(input.value);
              }
            } : null,
          onClick: props.onClick,
        #end
      },
    });
  }

}
