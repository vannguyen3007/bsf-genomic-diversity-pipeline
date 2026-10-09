process VALIDATE_INPUT {
 input: path sheet
 output: path "validated_samplesheet.csv"
 script:
 """
 python ${projectDir}/bin/validate_samplesheet.py ${sheet}
 cp ${sheet} validated_samplesheet.csv
 """
}
