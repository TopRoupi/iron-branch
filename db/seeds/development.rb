# direct and indirect participation tree
# Company_A
# ├─50%─>>>>> Company_B
# ├─25%──────├─50%─>>>>> Company_C
# ├─6.25%────├─25%───────├─50%─>>>>> Company_D
# 
# just direct participation tree
# Company_A
# ├─50%─>>>>> Company_B
# ├──────────├─50%─>>>>> Company_C
# ├──────────├───────────├─50%─>>>>> Company_D
# 

# name: 'company_a'
# capital: 100
# investments:
#   - invested:
#       name: 'company_b'
#       capital: 100
#       investments:
#         - invested:
#             name: 'company_c'
#             capital: 100
#             investiments:
#               - invested:
#                   name: 'company_d'
#                   capital: 100
#                   investments: []
#                   investors:
#                     - name: 'company_c'
#                       capital: 100
#                       percentage: 50
#                     - name: 'company_b'
#                       capital: 100
#                       percentage: 25
#                     - name: 'company_a'
#                       capital: 100
#                       percentage: 6.25
#                 value: 50
#             investors:
#               - name: 'company_b'
#                 capital: 100
#                 percentage: 50
#               - name: 'company_a'
#                 capital: 100
#                 percentage: 25
#           value: 50
#       investors:
#         - name: 'company_a'
#           capital: 100
#           percentage: 50
#     value: 50
# investors: []

# # A     B     C     D
# [[0.00, 50.0, 0.00, 0.00], #A
#  [0.00, 0.00, 50.0, 0.00], #B
#  [0.00, 0.00, 0.00, 50.0], #C
#  [0.00, 0.00, 0.00, 0.00]] #D

#  # A     B     C     D
# [[0.00, 50.0, 25.0, 6.25], #A
#  [0.00, 0.00, 50.0, 25.0], #B
#  [0.00, 0.00, 0.00, 50.0], #C
#  [0.00, 0.00, 0.00, 0.00]] #D

# # A     B     C     D
# [[00.00, 150.0, 025.0, 06.25], #A
#  [00.00, 00.00, 150.0, 025.0], #B
#  [00.00, 00.00, 00.00, 150.0], #C
#  [00.00, 00.00, 00.00, 00.00]] #D


company_a = FactoryBot.create :company,
                              capital: 100,
                              name: "Company_A"

company_b = FactoryBot.create :company,
                              capital: 100,
                              name: "Company_B"

company_c = FactoryBot.create :company,
                              capital: 100,
                              name: "Company_C"

company_d = FactoryBot.create :company,
                              capital: 100,
                              name: "Company_D"

FactoryBot.create :investment,
                  investor: company_a,
                  invested: company_b,
                  value: 50

FactoryBot.create :investment,
                  investor: company_b,
                  invested: company_c,
                  value: 50

FactoryBot.create :investment,
                  investor: company_c,
                  invested: company_d,
                  value: 50