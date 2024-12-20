## CD.6 - Minimum and Maximum Data Values (NR)

this is the frequency of transmitted data, which may or may not be the actual frequency at which the data was acquired by an analog-to-digital converter or other digital data source (i.e. the data transmitted may be subsampled, or interpolated, from the originally acquired data.)

This component defines the minimum and maximum data values which can occur in this channel in the digital waveform data, that is, the range of the ADC. , and also specifies whether or not non-integral data values may occur in this channel in the waveform data. If the minimum and maximum values are both integers (or not present), only integral data values may be used in this channel. If either the minimum or the maximum value contains a decimal point, then non-integral as well as integral data values may be used in this channel. For an n-bit signed ADC, the nominal baseline B = 0, and the minimum (L) and maximum (H) values may be calculated as follows:

L = -2n^-1^

H = 2n^-1^ - 1

For an unsigned n-bit ADC, the minimum value L = 0, and the nominal baseline value (B) and maximum value (H) may be calculated from the formulas,

B = 2n^-1^

H = 2n - 1

The actual signal amplitude A (for differentially amplified potential measurements, the potential at electrode number one minus that at electrode number two) may be calculated from the value D (range L to H) in the waveform data using the actual baseline value B and the nominal sensitivity S and actual sensitivity correction factor C by the formula,

_A = SC(D-B)_
