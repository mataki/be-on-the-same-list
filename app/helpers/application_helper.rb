# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def twitter_url(screen_name)
    "http://twitter.com/#{h screen_name}"
  end

  def update_status_on_twitter_url(status, options = {})
    uri = URI.join("http://twitter.com/")
    query = options.update(:status => status)
    uri.query = query.to_query
    uri.to_s
  end

  def google_analitics_tag
    <<-EOF
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-15821811-1");
pageTracker._setDomainName(".mat-aki.net");
pageTracker._trackPageview();
} catch(err) {}</script>
EOF
  end
end
