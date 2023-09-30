#![cfg_attr(not(feature = "std"), no_std)]

#[ink::contract]
mod minter {
    #[ink(storage)]
    pub struct Minter {
        value: u32,
    }

    pub impl Minter {
        #[ink(constructor)]
        pub fn new_value(init_value: u32) -> Self {
            Self {
                value: init_value
            }
        }

        #[ink(message)]
        pub fn minter(&mut self) -> u32 {
            self.value += 1
        }

    }
}
