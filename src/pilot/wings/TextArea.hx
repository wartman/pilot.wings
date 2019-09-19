package pilot.wings;

import pilot.VNode;
import pilot.Style;
#if js
  import js.html.Event;
  import js.html.KeyboardEvent;
  import js.html.TextAreaElement;
#end

abstract TextArea(VNode) to VNode {
  
  public inline function new(props:{
    id:String,
    ?content:String,
    ?style:Style,
    ?required:Bool,
    ?disabled:Bool,
    #if js
      ?onCommit:(content:String)->Void,
      ?onChange:(content:String)->Void,
      ?onBlur:(e:Event)->Void,
      ?onClick:(e:Event)->Void,
    #end
  }) {
    this = new VNode({
      name: 'textarea',
      props: {
        id: props.id,
        name: props.id,
        required: props.required,
        disabled: props.disabled,
        value: props.content,
        #if js
          onKeyup: props.onCommit != null
            ? (e:Event) -> {
              var e:KeyboardEvent = cast e;
              if (e.key == 'Enter') {
                var input:TextAreaElement = cast e.target;
                props.onCommit(input.value);
              }
            } : null,
          onBlur: props.onBlur,
          onChange: props.onChange != null
            ? (e:Event) -> {
              var input:TextAreaElement = cast e.target;
              props.onChange(input.value);
            } : null,
          onClick: props.onClick,
        #end
      }
    });
  }

}