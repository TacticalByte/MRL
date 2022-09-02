import React from 'react';
import { render, screen } from '@testing-library/react';
import Navbar from '../../components/Navbar';

describe('Group of test for Navbar', () =>{
    test('Rendering Navbar', () => {
        render(<Navbar />);
        const linkElement = screen.getByText(/MRL/i);
        expect(linkElement).toBeInTheDocument();
      })
});

