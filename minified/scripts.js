---
permalink: /assets/js/scripts.min.js
---

{% capture scripts %}
  {% include assets/js/jquery-2.1.4.min.js %}
  {% include assets/js/bootstrap.min.js %}
  {% include assets/js/jquery.flexslider-min.js %}
  {% include assets/js/jquery.appear.js %}
  {% include assets/js/jquery.plugin.js %}
  {% include assets/js/jquery.simple-lightbox.min.js %}
  {% include assets/js/jquery.waypoints.min.js %}
  {% include assets/js/jquery.validate.min.js %}
  {% include assets/js/toastr.min.js %}
  {% include assets/js/jquery.bxslider.min.js %}
  {% include assets/js/startuply.js %}
  {% include assets/js/contact.js %}
{% endcapture %}

{{ scripts | uglify }}
