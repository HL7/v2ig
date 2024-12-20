## RP.2 - Application ID (HD)

A unique designator of the system that stores the data. It is an HD data type (See Section _2A.2.33_, "_HD - hierarchic designator_"). Application ID’s must be unique across a given HL7 implementation.

**Usage Note:** The Application ID together with the Pointer may form a Uniform Resource Identifier (URI) in accordance with RFC 2396. In this case the Application ID shall include the Scheme and Authority parts of the URI, and the Path part if that points to an application. The Pointer shall include the Query part of the URI, or the Path part if that points to an object. All delimiters between URI parts (“:”, “/”, “?”) should be included in the components.

Referenced data may be obtained by a mechanism not defined in the HL7 standard. The Scheme part of a URI in the Application ID specifies the access protocol, e.g., HTTP or FTP.

**Example 1:** A CDA document accessed by FTP:

|/cdasvc/u28864099/s9076500a/e77534/d55378.xml\^&ftp://www.saintelsewhere.org&URI^text^x-hl7-cda-level-one|

**Example 2:** A DICOM image accessed by HTTP and converted to JPEG (using the ISO/DICOM WADO standard);

the ampersands in the Pointer string are escaped to “\T\” to avoid conflict with the sub-component delimiter:

|?requestType=WADO\T\study=1.2.840.113848.5.22.9220847989\T\series=1.2.840.113848.5.22.922084798.4\T\object=1.2.840.113848.5.22.922084798.4.5\^&https://www.pacs.poupon.edu/wado.jsp&URI^image^jpeg|
