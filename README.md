# `evil.sh` (aka. `devili.sh`)

A collection of various subtle and not-so-subtle shell tweaks that will drive people insane.

Feel like completely destroying a colleagues system? Just add `source ~/evil.sh` to their `.bash_profile` and watch the chaos ensue.
Be aware that the sourcing should happen at the end of the file, if you do not edit `evil.sh` before doing so, as `evil.sh` disables `alias` and `unalias`.

## Contributions

Evil suggestions and pull requests are welcome. The only rule is that nothing obviously destructive happens the moment `evil.sh` is sourced. Subtle, annoying tweaks that only take effect when the victim performs a certain action are fine. On the other hand, a patch that adds `rm -rfv /` to `evil.sh` will be rejected.

## See also

* [`evil.js`](https://github.com/kitcambridge/evil.js)
* [`evil.css`](https://github.com/tlrobinson/evil.css)

## Credits

| [![twitter/mathias](https://gravatar.com/avatar/24e08a9ea84deb17ae121074d0f17125?s=70)](https://twitter.com/mathias "Follow @mathias on Twitter") | [![twitter/janmoesen](https://gravatar.com/avatar/f0e6c7e4835c71c987b13e0dc4ed3a72?s=70)](https://twitter.com/janmoesen "Follow @janmoesen on Twitter") |
|---|---|
| [Mathias Bynens](https://mathiasbynens.be/) | [Jan Moesen](http://jan.moesen.nu/) |

## License

Public domain.

## Obligatory disclaimer

`evil.sh` is purely for entertainment purposes. I’m not responsible for anything you do with `evil.sh`.
