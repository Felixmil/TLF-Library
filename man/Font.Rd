% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/font.R
\name{Font}
\alias{Font}
\title{Font}
\description{
R6 class defining font properties
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{size}}{numeric defining the size of font}

\item{\code{color}}{character defining the color of font}

\item{\code{fontFamily}}{character defining the family of font}

\item{\code{fontFace}}{character defining the font face as defined in helper enum \code{FontFaces}.}

\item{\code{angle}}{numeric defining the angle of font}

\item{\code{align}}{character defining the alignment of font as defined in helper enum \code{Alignments}.}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-Font-new}{\code{Font$new()}}
\item \href{#method-Font-createPlotFont}{\code{Font$createPlotFont()}}
\item \href{#method-Font-clone}{\code{Font$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Font-new"></a>}}
\if{latex}{\out{\hypertarget{method-Font-new}{}}}
\subsection{Method \code{new()}}{
Create a new \code{Font} object.
Default font properties are defined directly in the object field,
so \code{NULL} input is allowed will lead to default properties.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Font$new(
  color = NULL,
  size = NULL,
  fontFamily = NULL,
  fontFace = NULL,
  angle = NULL,
  align = NULL
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{color}}{character defining the color of font}

\item{\code{size}}{numeric defining the size of font}

\item{\code{fontFamily}}{character defining the family of font}

\item{\code{fontFace}}{character defining the font face as defined in helper enum \code{FontFaces}.}

\item{\code{angle}}{numeric defining the angle of font}

\item{\code{align}}{character defining the alignment of font as defined in helper enum \code{Alignments}.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A new \code{Font} object
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Font-createPlotFont"></a>}}
\if{latex}{\out{\hypertarget{method-Font-createPlotFont}{}}}
\subsection{Method \code{createPlotFont()}}{
Create a \code{ggplot2::element_text} directly convertible by \code{ggplot2::theme}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Font$createPlotFont(
  size = NULL,
  color = NULL,
  fontFamily = NULL,
  fontFace = NULL,
  angle = NULL,
  align = NULL
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{size}}{numeric defining the size of font}

\item{\code{color}}{character defining the color of font}

\item{\code{fontFamily}}{character defining the family of font}

\item{\code{fontFace}}{character defining the font face as defined in helper enum \code{FontFaces}.}

\item{\code{angle}}{numeric defining the angle of font}

\item{\code{align}}{character defining the alignment of font as defined in helper enum \code{Alignments}.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
An \code{element_text} object.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Font-clone"></a>}}
\if{latex}{\out{\hypertarget{method-Font-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Font$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
