# ggChernoff (development version)

* Exported the `GeomChernoff` ggproto object, in line with the convention
  used by other 'ggplot2' extension packages, so it can be extended by
  other packages.
  
* Added a `linewidth` aesthetic to `geom_chernoff()`/`chernoffGrob()`, which
  controls the stroke width of the face outline and features (previously
  `linewidth` was silently ignored).
  
* Fixed deprecation warnings from `scale_smile()`, `scale_brow()` and
  `scale_eyes()` caused by passing the now-deprecated `scale_name` argument
  to `continuous_scale()`.
  
* Bumped the minimum required version of ggplot2 to 3.5.0.

# ggChernoff 0.3.0

* Added an `eyes` aesthetic to control the distance between eyes.

# ggChernoff 0.2.0

* Initial submission to CRAN.

# ggChernoff 0.1.2.9001

* Added a `NEWS.md` file to track changes to the package.
* Tweaked `chernoffGrob` to make smiles more prominent, thanks to feedback from Lewis Rendell.

# ggChernoff 0.1.1.9001

* Added a more illustrative example for `scale_brow_continuous`.

# ggChernoff 0.1.1.9000

* Implemented data-driven eyebrows via the `brow` aesthetic.



