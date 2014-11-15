---
layout: blog
title: Ember.js data appcache
pretty_title: Ember.js, Ember Data, and the application cache are on an island
---
It has been said numerous times in the past, [the application cache can occasionally be a douchebag](http://alistapart.com/article/application-cache-is-a-douchebag). Not that it is not doing its job, but the way the whole thing works is not really intuitive and hard to grasp at times.

Over the past few months, I've been working on a web application for one of our clients at [Novelys](http://www.novelys.com), developed with Ember.js and with offline availability, [which I've already written at length about](http://www.novelys.com/blog/2014/02/28/building-app-ember-html5-storage.html), but I wanted to come back on a specific issue I recently remembered, with hopes that it might save somebody's time someday.

The application itself is a sort of file explorer, with the URLs looking like  `/category/:id`. Every url of this kind is listed in the manifest file to make sure users can access the application offline from any URL. For a given category, Ember Data hits `/category/:id` with a `Content-Type` of `application/json` to fetch the relevant data. So far, so good!

But see, once your application is cached, every resource listed in the manifest will always be fetched from the cache even if there is network connectivity. So yep, at that point, Ember Data will hit `/category/:id` and the appcache will return what it has in store (which is the HTML version of the page), completely disregarding the `Content-Type` of the request made by Ember Data.

The solution is pretty straightforward: I had to override the application adapter to force the use of a `.json` extension so there's no URL conflict:

{% gist ksol/b52cf88899635ea72fb8 %}

Pretty obvious when you know how the application cache works; a bit less when you are not yet used to deal with its specificities. I hope this helps !
